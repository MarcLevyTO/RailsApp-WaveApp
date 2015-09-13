RakeFileUtils.verbose(false)

namespace :importer do
  desc "Import csv data"
  task :import_csv_data, [:arg1] => :environment do |t, args|
    # task.perform_unless_is_running(:lock_file_name => 'import_csv_data') do
      # puts args
      file = File.open(args[:arg1])
      arg2 = 16
      company = Company.find(arg2)
      company.import(file)

      puts company.company_datum.all.to_yaml

      grouped_datum = company.grouped_monthly
      grouped_datum.sort.each do |month, data|
        total_pre_tax_amount = 0
        total_tax_amount = 0
        for datum in data
          total_pre_tax_amount += datum.pre_tax_amount
          total_tax_amount += datum.tax_amount
        end
        puts month.strftime('%B %Y')
        puts total_pre_tax_amount
        puts total_tax_amount
      end

    # end
  end
end