class CreateSpinaSchools < ActiveRecord::Migration[6.0]
  def change
    create_table :spina_schools do |t|
      t.string :title
    end
  end
end
