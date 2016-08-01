require 'optparse'

#引数の取得
def get_args
    args = {}
    OptionParser.new do
        |parser|
        parser.on('-d', '--decode', '復号化の場合は指定') { |v| args[:decode] = v }
        parser.on('-v VALUE', '--value VALUE', '変換値(必須)') { |v| args[:value] = v }
        parser.parse!(ARGV)
    end
    args
end

#カエサル暗号のアレンジ
#'-d' の指定がない場合はcharコードに+13してstringに変換
#'-d' の指定がある場合はcharコードに-13してstringに変換
def value_conversion(target, is_decode)
    if target.nil? || target.empty? then
        return '引数に "-v {VALUE}"を指定してください'
    end

    result = ''
    adding_subtract_value = is_decode ? -13 : 13
    target.each_char do
        |c|
        result += (/[^a-zA-z\s\r\n\t]/ === c) ? (c.ord + adding_subtract_value).chr('UTF-8') : c
    end
    result
end

#コマンドライン引数の取得
args = get_args
#'-d'オプションの取得
is_decode = args[:decode]
#暗号化 or 復号化する文字列の取得
value = args[:value]

#コンソールへ出力
puts value_conversion(value, is_decode)