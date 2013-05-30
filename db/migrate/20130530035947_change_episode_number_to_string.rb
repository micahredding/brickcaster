class ChangeEpisodeNumberToString < ActiveRecord::Migration
  def up
    change_table :episodes do |t|
      t.change :episode_number, :string
    end
  end

  def down
    change_table :episodes do |t|
      t.change :episode_number, :number
    end
  end
end
