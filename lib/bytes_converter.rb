# frozen_string_literal: true

class BytesConverter
  class << self
    def bytes_to_kilobytes(bytes)
      bytes / 1024
    end

    def kilobytes_to_megabytes(kbytes)
      kbytes / 1024
    end

    def megabytes_to_gigabytes(mbytes)
      mbytes / 1024
    end

    def bytes_to_gigabytes(bytes)
      (megabytes_to_gigabytes(kilobytes_to_megabytes(bytes_to_kilobytes(bytes))) / 1.0)
    end

    def prettify_float(number)
      left_side = number.to_s.split('.')[0].to_i
      precision = if left_side == 0
                    4
                  elsif left_side.to_s.size == 1
                    3
                  elsif left_side.to_s.size == 2
                    2
                  else
                    1
                  end

      number.round(precision)
    end
  end
end
