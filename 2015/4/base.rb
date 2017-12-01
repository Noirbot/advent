require 'digest'

secret = 'yzbqklnj'
i = 1
found = false

md5 = Digest::MD5.new

while (!found) do
  hex = md5.hexdigest(secret + i.to_s)
  if (hex[0..5] == '000000')
    found = true
    puts hex
    puts i
  end
  i = i + 1
end
