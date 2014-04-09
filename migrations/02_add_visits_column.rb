Sequel.migration do
  up do
    add_column :url_table, :visits, Integer, :default => 0
  end

  down do
    drop_column :url_table, :visits
  end
end