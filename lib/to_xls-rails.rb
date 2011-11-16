require 'spreadsheet'

class Array

  def to_xls(options = {}, &block)
    return '' if self.empty?
    
    options.reverse_merge!(:header => true)

    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet

    if options[:only]
      columns = Array(options[:only]).map(&:to_sym)
    else
      columns = self.first.class.column_names.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
    end

    return '' if columns.empty?

    if options[:header]
      sheet.row(0).concat(options[:header_columns].blank? ? columns.map(&:to_s).map(&:humanize) : options[:header_columns])
    end

    self.each_with_index do |obj, index|
      index = options[:header] ? (index + 1) : index
      if block
        sheet.row(index).replace(columns.map { |column| block.call(column, obj.send(column)) })
      else
        sheet.row(index).replace(columns.map { |column| obj.send(column) })
      end
    end

    book.write(xls_report)

    xls_report.string
  end

end
