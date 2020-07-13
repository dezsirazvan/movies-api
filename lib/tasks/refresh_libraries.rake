
task refresh_libraries: :environment do
  purchases = Purchase.not_in_library
  purchases.destroy_all
end
