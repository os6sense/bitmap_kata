# SImple presenter to output a bitmap
class BitmapPresenter
  def show(bitmap, out: STDOUT)
    bitmap.each do |row|
      row.each do |col|
        out.write col.value
      end
      out.write "\n"
    end
  end
end
