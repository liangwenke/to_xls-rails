require 'spreadsheet'

class Array

  def to_xls(options = {}, &block)

    return '' if self.empty? && options[:prepend].blank?

    columns = []
    options.reverse_merge!(:header => true)

    xls_report = StringIO.new

    Spreadsheet.client_encoding = options[:client_encoding] || "UTF-8"

    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet

    if options[:only]
      columns = Array(options[:only]).map(&:to_sym)
    elsif !self.empty?
      if self.first.is_a? Hash
        columns = self.first.keys.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
      else
        columns = self.first.attributes.keys.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
      end
    end

    return '' if columns.empty? && options[:prepend].blank?

    sheet_index = 0

    unless options[:prepend].blank?
      options[:prepend].each do |array|
        sheet.row(sheet_index).concat(array)
        sheet_index += 1
      end
    end

    if options[:header]
      sheet.row(sheet_index).concat(options[:header_columns].blank? ? columns.map(&:to_s).map(&:humanize) : options[:header_columns])
      sheet_index += 1
    end

    if options[:column_width]
      options[:column_width].each_index {|index| sheet.column(index).width = options[:column_width][index]}
    end

    self.each_with_index do |obj, index|
      if block
        sheet.row(sheet_index).replace(columns.map { |column| block.call(column, obj.is_a?(Hash) ? obj[column] : obj.send(column), index) })
      else
        sheet.row(sheet_index).replace(columns.map { |column| obj.is_a?(Hash) ? obj[column] : obj.send(column) })
      end
      sheet_index += 1
    end

    unless options[:append].blank?
      options[:append].each do |array|
        sheet.row(sheet_index).concat(array)
        sheet_index += 1
      end
    end

    book.write(xls_report)

    xls_report.string
  end

end
