class Company < ActiveRecord::Base

  has_many :company_datum

  def import(file)
    CSV.foreach(file.path, headers: true) do |row|
      new_hash = {'company_id' => self.id}
      row.to_hash.each_pair do |k,v|
        # Handle formatting of date
        if ( k == 'date' )
          new_hash.merge!({'date' => Date.strptime(v, '%m/%d/%Y')})
        else
          # Handle transform of header row to make space and dash into underscore
          new_hash.merge!({k.tr(' ', '_').tr('-','_') => v})
        end
      end
      begin
        company_datum = CompanyDatum.create! new_hash.to_hash
      rescue

      end
    end
  end

end
