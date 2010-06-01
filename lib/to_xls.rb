require 'spreadsheet'
require 'ruby-debug'

class Array
  def to_xls
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    
    columns = self.first.class.columns
    sheet.row(0).concat(columns.collect(&:human_name))
    line = 2
    self.each do |obj|
      sheet.row(line).push( columns.collect{ |column| obj.send(column.name) } )
      line += 1
    end
    
    book.write(xls_report)
    
    xls_report.string
  end
end
