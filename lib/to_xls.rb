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
      columns = self.first.class.columns - Array(options[:except]).map(&:to_sym)
    end
    
    return '' if columns.empty?
    
    sheet.row(0).concat(columns.collect(&:human_name))
    
    self.each_with_index do |obj, index|
      sheet.row(index + 1).replace( columns.collect{ |column| obj.send(column.name) } )
    end
    
    book.write(xls_report)
    
    xls_report.string
  end
  
end
