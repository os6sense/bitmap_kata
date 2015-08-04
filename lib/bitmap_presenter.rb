# Simple presenter to output a bitmap. The +show+ method is expected to be
# called to output the bitmap passed as the first parameter of that method.
class BitmapPresenter
  # == PARAMS
  # +bitmap+::    - the bitmap to print.
  # +out:+::      - optional, the output IO object to write to.
  #                 (default: $stdout)
  def show(bitmap, out: $stdout)
    bitmap.each do |row|
      row.each do |col|
        out.write col.value
      end
      out.write "\n"
    end
  end
end
