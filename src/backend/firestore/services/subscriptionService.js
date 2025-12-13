import { firestore } from '@src/firebaseConfig.js'
import { SubscriptionModel } from '@model/SubscriptionModel.js'
import { collection, addDoc, doc, getDoc, getDocs, query, where, orderBy, limit, updateDoc, serverTimestamp, onSnapshot } from 'firebase/firestore'
import { ActivityService } from '@backend/firestore/services/activityService.js'

const SUBSCRIPTIONS = 'subscriptions'
const USER_SUBSCRIPTIONS = 'user_subscriptions'
const USERS = 'users'

export const SubscriptionService = {
  createSubscription: async ({ title, price, courses = [], durationDays = 30 }) => {
    const sub = new SubscriptionModel({
      title,
      price,
      courses,
      durationDays,
      archived: false,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    })
    const ref = await addDoc(collection(firestore, SUBSCRIPTIONS), sub.toFirestore())
    return { id: ref.id }
  },
  
  getActiveSubscriptions: async () => {
    const q = query(collection(firestore, SUBSCRIPTIONS), where('archived', '==', false))
    const snap = await getDocs(q)
    return snap.docs.map(d => SubscriptionModel.fromFirestore(d.data(), d.id))
  },
  
  updateSubscription: async (id, updates) => {
    const ref = doc(firestore, SUBSCRIPTIONS, id)
    await updateDoc(ref, { ...updates, updatedAt: serverTimestamp() })
  },
  
  subscribeStudent: async ({ userId, subscriptionId, startDate = new Date() }) => {
    const userRef = doc(firestore, USERS, userId)
    const userSnap = await getDoc(userRef)
    const userData = userSnap.data() || {}
    const role = (userData.role || '').toString().trim().toLowerCase()
    
    const subRef = doc(firestore, SUBSCRIPTIONS, subscriptionId)
    const subSnap = await getDoc(subRef)
    const sub = SubscriptionModel.fromFirestore(subSnap.data() || {}, subSnap.id)
    
    const activatedAt = startDate
    const expiresAt = sub.getEndDate(activatedAt)
    
    await addDoc(collection(firestore, USER_SUBSCRIPTIONS), {
      userId,
      subscriptionId,
      activatedAt,
      expiresAt,
      durationDays: sub.durationDays,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    })
    
    const isStudent = role === 'student' || role === 'etudiant'
    if (isStudent) {
      await updateDoc(userRef, { status: 'subscribed', updatedAt: serverTimestamp() })
    }
    await ActivityService.logSubscriptionActivated({ userId, planTitle: sub.title, durationDays: sub.durationDays })
  },
  
  checkSubscriptionStatusForUser: async (userId) => {
    const userRef = doc(firestore, USERS, userId)
    const userSnap = await getDoc(userRef)
    if (!userSnap.exists()) return
    const userData = userSnap.data()
    const role = (userData.role || '').toString().trim().toLowerCase()
    const isStudent = role === 'student' || role === 'etudiant'
    if (!isStudent) return
    
    const q = query(
      collection(firestore, USER_SUBSCRIPTIONS),
      where('userId', '==', userId),
      orderBy('activatedAt', 'desc'),
      limit(1)
    )
    const snap = await getDocs(q)
    if (snap.empty) {
      await updateDoc(userRef, { status: 'inactive', updatedAt: serverTimestamp() })
      return
    }
    const data = snap.docs[0].data()
    const expiresAt = SubscriptionModel.parseDate(data.expiresAt)
    const now = new Date()
    const expired = now.getTime() >= expiresAt.getTime()
    await updateDoc(userRef, { status: expired ? 'inactive' : 'subscribed', updatedAt: serverTimestamp() })
  },
  
  performExpirySweep: async () => {
    const usersSnap = await getDocs(collection(firestore, USERS))
    const studentIds = usersSnap.docs
      .map(d => ({ id: d.id, role: (d.data().role || '').toString().trim().toLowerCase() }))
      .filter(u => u.role === 'Student')
      .map(u => u.id)
    
    for (const uid of studentIds) {
      await SubscriptionService.checkSubscriptionStatusForUser(uid)
    }
  },
  
  updateUserStatusProtected: async (userId, nextStatus) => {
    const userRef = doc(firestore, USERS, userId)
    const userSnap = await getDoc(userRef)
    const userData = userSnap.data() || {}
    const role = (userData.role || '').toString().trim().toLowerCase()
    const isStudent = role === 'student' || role === 'etudiant'
    if (isStudent) return { ok: false, reason: 'status-managed-by-subscription' }
    await updateDoc(userRef, { status: nextStatus, updatedAt: serverTimestamp() })
    return { ok: true }
  },
  
  watchUserSubscriptionsRealtime: (userId, onStatusChanged) => {
    const q = query(
      collection(firestore, USER_SUBSCRIPTIONS),
      where('userId', '==', userId),
      orderBy('activatedAt', 'desc'),
      limit(1)
    )
    const unsub = onSnapshot(q, async () => {
      await SubscriptionService.checkSubscriptionStatusForUser(userId)
      if (typeof onStatusChanged === 'function') onStatusChanged()
    })
    return unsub
  },
}
