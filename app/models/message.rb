class Message < ActiveRecord::Base
  attr_accessible :content, :from, :sender_id, :subject, :to, :recipient_id, :uid, :is_archived, :is_starred, :is_read
  validates :content, :presence => true
  validates :sender_id, :presence => true
  validates :recipient_id, :presence => true

  belongs_to :sender,
             :class_name => 'User'
  belongs_to :recipient,
             :class_name => 'User'

  scope :receive_msg_by_user, ->(recipient_id) { where(:recipient_id => recipient_id) }
  scope :archived, -> { where(:is_archived => true) }
  scope :un_archived, -> { where(:is_archived => false) }
  scope :read, -> { where(:is_read => true) }
  scope :un_read, -> { where(:is_read => false) }
  scope :starred, -> { where(:is_starred => true) }
  scope :un_starred, -> { where(:is_starred => false) }

  def self.update_messages(params)
    hash = {}
    if params[:mark_as].present?
      case params[:mark_as]
        when 'archived'
          hash = {:is_archived => true}
        when 'un_archived'
          hash = {:is_archived => false}
        when 'read'
          hash = {:is_read => true}
        when 'un_read'
          hash = {:is_read => false}
        when 'starred'
          hash = {:is_starred => true}
        when 'un_starred'
          hash = {:is_starred => false}
        else
          hash
      end

    end
    self.update_all(hash, {:uid => params[:message_ids]}) if hash.present?
    hash
  end

  def self.inbox(current_user, params)
    conditions = build_inbox_type(params)
    msg_ids = self.select('MAX(id)').receive_msg_by_user(current_user.id).where(conditions).group(:sender_id)
    Message.where(:id => msg_ids).order("updated_at DESC")
  end

  def self.build_inbox_type(params)
    conditions = []
    if params[:type].present?
      conditions = with_archived_un_archived(conditions, params)
      conditions = with_read_unread(conditions, params)
      conditions = with_starred_un_starred(conditions, params)
    end
    conditions
  end

  def self.with_archived_un_archived(conditions, params)
    conditions = with_archived(conditions, params)
    conditions = with_unarchived(conditions, params)
  end

  def self.with_read_unread(conditions, params)
    conditions = with_read(conditions, params)
    conditions = with_un_read(conditions, params)
  end

  def self.with_starred_un_starred(conditions, params)
    conditions = with_starred(conditions, params)
    conditions = with_un_starred(conditions, params)
  end

  def self.with_archived(conditions, params)
    if params[:type] == 'archived'
      if conditions[0].blank?
        conditions[0] = "messages.is_archived = ?"
      else
        conditions[0] << " AND "
        conditions[0] << "messages.is_archived = ?"
      end
      conditions.push(true)
    end
    conditions
  end

  def self.with_unarchived(conditions, params)
    if params[:type] == 'un_archived'
      if conditions[0].blank?
        conditions[0] = "messages.is_archived = ?"
      else
        conditions[0] << " AND "
        conditions[0] << "messages.is_archived = ?"
      end
      conditions.push(false)
    end
    conditions
  end

  def self.with_read(conditions, params)
    if params[:type] == 'read'
      if conditions[0].blank?
        conditions[0] = "messages.is_read = ?"
      else
        conditions[0] << " AND "
        conditions[0] << "messages.is_read = ?"
      end
      conditions.push(true)
    end
    conditions
  end

  def self.with_un_read(conditions, params)
    if params[:type] == 'un_read'
      if conditions[0].blank?
        conditions[0] = "messages.is_read = ?"
      else
        conditions[0] << " AND "
        conditions[0] << "messages.is_read = ?"
      end
      conditions.push(false)
    end
    conditions
  end

  def self.with_starred(conditions, params)
    if params[:type] == 'starred'
      if conditions[0].blank?
        conditions[0] = "messages.is_starred = ?"
      else
        conditions[0] << " AND "
        conditions[0] << "messages.is_starred = ?"
      end
      conditions.push(true)
    end
    conditions
  end

  def self.with_un_starred(conditions, params)
    if params[:type] == 'un_starred'
      if conditions[0].blank?
        conditions[0] = "messages.is_starred = ?"
      else
        conditions[0] << " AND "
        conditions[0] << "messages.is_starred = ?"
      end
      conditions.push(false)
    end
    conditions
  end

end
