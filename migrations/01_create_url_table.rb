Sequel.migration do
  up do
    create_table :url_table do
      primary_key :permalink
      String :original_url
      String :redirect_url
    end
  end

  down do
    drop_table :url_table
  end
end