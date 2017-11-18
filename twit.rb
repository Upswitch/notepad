
require 'twitter'

class Twit < Post

  @@CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key = 'ymkbifvdljPFjuPdCbSu4b4Ee'
    config.consumer_secret = 'rPpUPuaMXaPUgkqBR486DRjNJ2nMztbHhpp51N2hDvdquwWplO'
    config.access_token = '931742791037841408-J8rMLglYR6HuhJiresdyoonBHZ9yxVY'
    config.access_token_secret = 'UkudW2ti2pU4BAGnNW904oWOOd986ipefAEszRIYYkKTa'
  end

  def read_from_console
    puts "Новый твит (140 символов!):"

    @text = STDIN.gets.chomp[0..140]

    puts "Отправляем Ваш твит: #{@text.encode('UTF-8')}"
    @@CLIENT.update(@text.encode('UTF-8'))
    puts "Твит отправлен."
  end

  # Массив из даты создания + тело твита
  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    return @text.unshift(time_string)

  end

  def to_db_hash
    return super.merge(
        {
            'text' => @text # наш твит
        }
    )
  end

  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для инициализации общих полей

    # теперь прописываем свое специфичное поле
    @text = data_hash['text'].split('\n\r')
  end
end