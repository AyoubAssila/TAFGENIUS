import { firestore } from '@src/firebaseConfig.js'
import { collection, addDoc, serverTimestamp } from 'firebase/firestore'

const ACTIVITY = 'activity'

export const ActivityService = {
  async log({ type = '', userId = '', email = '', message = '', details = '', courseId = '', lessonId = '', icon = '•' }) {
    await addDoc(collection(firestore, ACTIVITY), {
      type,
      userId,
      email,
      message,
      details,
      courseId,
      lessonId,
      icon,
      timestamp: serverTimestamp(),
    })
  },
  async logAuthLogin({ userId, email, success = true }) {
    await ActivityService.log({
      type: 'auth',
      userId,
      email,
      message: success ? 'Successful login' : 'Failed login',
      icon: success ? '✅' : '❌',
    })
  },
  async logUserRegistered({ userId, email, role }) {
    await ActivityService.log({
      type: 'user',
      userId,
      email,
      message: 'New user registered',
      details: `Role: ${role}`,
      icon: '👤',
    })
  },
  async logSubscriptionActivated({ userId, planTitle, durationDays }) {
    await ActivityService.log({
      type: 'subscription',
      userId,
      message: 'Subscription activated',
      details: `${planTitle} (${durationDays} days)`,
      icon: '💳',
    })
  },
}
