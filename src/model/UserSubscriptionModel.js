// src/models/UserSubscriptionModel.js
export class UserSubscriptionModel {
  constructor({
    id = '',
    userId,
    subscriptionId,
    activatedAt,
    createdAt,
    updatedAt,
    active = false,
  }) {
    this.id = id;
    this.userId = userId;
    this.subscriptionId = subscriptionId;
    this.activatedAt = activatedAt;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.active = active;
  }

  // ----------- GETTERS -----------
  get startDate() {
    return this.activatedAt;
  }

  get endDate() {
    const end = new Date(this.activatedAt);
    end.setDate(end.getDate() + 30);
    return end;
  }

  get status() {
    return this.active ? 'active' : 'inactive';
  }

  // ----------- FACTORY FROM LEGACY -----------
  static fromLegacy({
    id = '',
    userId,
    subscriptionId,
    startDate,
    status = 'active',
  }) {
    const now = new Date();
    return new UserSubscriptionModel({
      id,
      userId,
      subscriptionId,
      activatedAt: startDate,
      createdAt: now,
      updatedAt: now,
      active: status === 'active',
    });
  }

  // ----------- TO MAP (POUR FIRESTORE) -----------
  toMap() {
    return {
      userId: this.userId,
      subscriptionId: this.subscriptionId,
      activatedAt: this.activatedAt.toISOString(),
      createdAt: this.createdAt.toISOString(),
      updatedAt: this.updatedAt.toISOString(),
      active: this.active,
    };
  }

  // ----------- FROM MAP (DEPUIS FIRESTORE) -----------
  static fromMap(map, id) {
    return new UserSubscriptionModel({
      id,
      userId: map.userId || '',
      subscriptionId: map.subscriptionId || '',
      activatedAt: UserSubscriptionModel.parseDate(map.activatedAt),
      createdAt: UserSubscriptionModel.parseDate(map.createdAt),
      updatedAt: UserSubscriptionModel.parseDate(map.updatedAt),
      active: map.active === true,
    });
  }

  // ----------- PARSE DATE UTIL -----------
  static parseDate(value) {
    if (!value) return new Date();

    try {
      if (typeof value === 'string') {
        return new Date(value);
      }

      if (typeof value === 'number') {
        return new Date(value);
      }

      if (value._seconds != null) {
        return new Date(value._seconds * 1000);
      }

      if (value.seconds != null) {
        return new Date(value.seconds * 1000);
      }

      if (value instanceof Date) {
        return value;
      }
    } catch (e) {
      console.error('Erreur de parsing DateTime:', e);
    }

    return new Date();
  }
}
