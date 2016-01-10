require 'net/http'
require 'uri'
require 'json'
require 'mecab'

namespace :word do

  desc 'process new messages'
  task :process_new_messages => :environment do

    word_with_last_processed_post = Word.all.order(last_post_id: :desc).limit(1)[0]
    if word_with_last_processed_post == nil
      last_processed_post_id = 0
    else
      last_processed_post_id = word_with_last_processed_post.last_post_id
    end

    puts 'last_processed_post_id: ' + last_processed_post_id.to_s
    puts ''

    target_posts = Post.all.where('id > ?',last_processed_post_id).order(id: :asc).limit(2000)

    target_posts.each do |post|

      noun_words = parse_noun(post.text)

      words_and_count = []

      noun_words.uniq.map do |noun_word|
        words_and_count[words_and_count.size] = ["#{noun_word}", "#{noun_words.grep(noun_word).count}"] if noun_word
      end

      puts 'post.id: ' + post.id.to_s
      puts words_and_count.to_s
      puts ''

      words_and_count.each do |word, count|
        create_or_add_word_count(word, count, post.id)
      end
    end
  end
end

def create_or_add_word_count(word, count, last_post_id)
  target_word = Word.where(word: word).limit(1)[0]
  if target_word == nil
    target_word = Word.new
    target_word.word = word
    target_word.count = count
  else
    target_word.count = (target_word.count.to_i + count.to_i).to_s
  end
  target_word.last_post_id = last_post_id
  target_word.save
end

def parse_noun(word)

  if word == "" or word == nil
    return []
  end

  mecab = MeCab::Tagger.new("-Ochasen")
  node = mecab.parseToNode(word)

  nouns = []
  while node
    # print node.surface, "\t", node.feature, "\t", node.cost, "\n"   # debug

    # 名詞を抽出する
    if /^名詞/ =~ node.feature.split(/,/)[0] then
      nouns.push(node.surface)
    end

    node = node.next
  end
  return nouns
end
