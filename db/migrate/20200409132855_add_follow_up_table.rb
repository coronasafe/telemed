class AddFollowUpTable < ActiveRecord::Migration[6.0]
  def change
    create_table :followups do |t|
      t.references :consultation
      t.references :action
      t.references :user
      t.references :completed_by
      t.datetime :completed_at
      t.timestamps
    end

    add_column :users, :name, :string
    add_column :users, :source, :string
  end
end
