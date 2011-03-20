require 'spreadsheet'

class Array

  def to_xls( options = {} )
    return '' if self.empty?
    
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    
    if options[:only]
      columns = Array(options[:only]).map(&:to_sym)
    else
      columns = self.first.class.column_names.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
    end
    
    return '' if columns.empty?
    
    sheet.row(0).concat(columns.map(&:to_s).map(&:humanize))
    
    self.each_with_index do |obj, index|
      sheet.row(index + 1).replace( columns.map{ |column| obj.send(column) } )
    end
    
    book.write(xls_report)
    
    xls_report.string
  end
  
end
