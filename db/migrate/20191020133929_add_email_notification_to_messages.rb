class AddEmailNotificationToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :email_notification, :boolean
  end
end
