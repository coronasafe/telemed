class AddTimestampsToVersions < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :consultation_versions
  end
end
