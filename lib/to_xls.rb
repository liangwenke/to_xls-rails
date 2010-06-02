require 'spreadsheet'

class Array
  def to_xls
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    
    columns = self.first.class.columns
    sheet.row(0).concat(columns.collect(&:human_name))
    self.each_with_index do |obj, index|
      sheet.row(index + 1).replace( columns.collect{ |column| obj.send(column.name) } )
    end
    
    book.write(xls_report)
    
    xls_report.string
  end
end
