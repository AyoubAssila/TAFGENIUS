// src/models/UserModel.js
import { Timestamp } from "firebase/firestore";

export class UserModel {
  constructor({
    id = '',
    name = '',
    email = '',
    password = '',
    role = 'etudiant',
    status = 'inactive',
    createdAt = new Date(),
    updatedAt = null,
    globalProgress = 0,
    progress = {},
    gender = null,
    age = null,
    subscriptions = [],
    purchasedCourses = [],
    accessRights = {},
  } = {}) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.password = password;
    this.role = role;
    this.status = status;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.globalProgress = globalProgress;
    this.progress = progress; // { [courseId]: Progress }
    this.gender = gender;
    this.age = age;
    this.subscriptions = subscriptions;
    this.purchasedCourses = purchasedCourses;
    this.accessRights = accessRights; // { [courseId]: AccessRight }
  }

  // --------------- Firestore mapping ----------------
  toMap() {
    return {
      name: this.name,
      email: this.email,
      ...(this.password ? { password: this.password } : {}),
      role: this.role,
      status: this.status,
      createdAt: Timestamp.fromDate(this.createdAt),
      ...(this.updatedAt ? { updatedAt: Timestamp.fromDate(this.updatedAt) } : {}),
      globalProgress: this.globalProgress,
      progress: Object.fromEntries(
        Object.entries(this.progress).map(([key, value]) => [key, value.toMap()])
      ),
      ...(this.gender ? { gender: this.gender } : {}),
      ...(this.age ? { age: this.age } : {}),
      subscriptions: this.subscriptions,
      purchasedCourses: this.purchasedCourses,
      accessRights: Object.fromEntries(
        Object.entries(this.accessRights).map(([key, value]) => [key, value.toMap()])
      ),
    };
  }

  static fromFirestore(doc) {
    const map = doc.data();
    return new UserModel({
      id: doc.id,
      name: map.name || '',
      email: map.email || '',
      password: map.password || '',
      role: map.role || 'etudiant',
      status: map.status || 'inactive',
      createdAt: map.createdAt?.toDate ? map.createdAt.toDate() : new Date(),
      updatedAt: map.updatedAt?.toDate ? map.updatedAt.toDate() : null,
      globalProgress: map.globalProgress?.toFixed ? Number(map.globalProgress) : 0,
      progress: map.progress
        ? Object.fromEntries(
            Object.entries(map.progress).map(([k, v]) => [k, Progress.fromMap(v)])
          )
        : {},
      gender: map.gender || null,
      age: map.age || null,
      subscriptions: map.subscriptions || [],
      purchasedCourses: map.purchasedCourses || [],
      accessRights: map.accessRights
        ? Object.fromEntries(
            Object.entries(map.accessRights).map(([k, v]) => [k, AccessRight.fromMap(v)])
          )
        : {},
    });
  }

  // --------------- Getters utilitaires ----------------
  get isStudent() {
    return this.role === 'etudiant';
  }
  get isContentWebmaster() {
    return this.role === 'webmaster_contenu';
  }
  get isTechnicalWebmaster() {
    return this.role === 'webmaster_technique';
  }
  get isCommercial() {
    return this.role === 'commercial';
  }
  get isAdmin() {
    return this.isContentWebmaster || this.isTechnicalWebmaster || this.isCommercial;
  }

  markUpdated() {
    this.updatedAt = new Date();
  }
}

// ---------------- Progress ----------------
export class Progress {
  constructor({ percent, lastLessonId, updatedAt = new Date(), completedLessonIds = [] }) {
    this.percent = percent;
    this.lastLessonId = lastLessonId;
    this.updatedAt = updatedAt;
    this.completedLessonIds = completedLessonIds;
  }

  toMap() {
    return {
      percent: this.percent,
      lastLessonId: this.lastLessonId,
      updatedAt: Timestamp.fromDate(this.updatedAt),
      completedLessonIds: this.completedLessonIds,
    };
  }

  static fromMap(map) {
    return new Progress({
      percent: map.percent || 0,
      lastLessonId: map.lastLessonId || '',
      updatedAt: map.updatedAt?.toDate ? map.updatedAt.toDate() : new Date(),
      completedLessonIds: map.completedLessonIds || [],
    });
  }
}

// ---------------- AccessRight ----------------
export class AccessRight {
  constructor({ hasAccess, reason, expiresAt }) {
    this.hasAccess = hasAccess;
    this.reason = reason;
    this.expiresAt = expiresAt;
  }

  toMap() {
    return {
      hasAccess: this.hasAccess,
      reason: this.reason,
      expiresAt: Timestamp.fromDate(this.expiresAt),
    };
  }

  static fromMap(map) {
    return new AccessRight({
      hasAccess: map.hasAccess || false,
      reason: map.reason || 'expired',
      expiresAt: map.expiresAt?.toDate ? map.expiresAt.toDate() : new Date(),
    });
  }
}
