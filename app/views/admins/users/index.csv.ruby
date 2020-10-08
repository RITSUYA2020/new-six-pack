require 'csv'

CSV.generate do |csv|
  csv_column_names = %w[名前 性別 メールアドレス]
  csv << csv_column_names
  @users.each do |user|
    csv_column_values = [
      user.name,
      user.sex_i18n,
      user.email
    ]
    csv << csv_column_values
  end
end
