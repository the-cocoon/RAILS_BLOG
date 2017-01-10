module PubTagViewModel
  class << self
    def get
      pub_tags = PubTag.published.min2max(:title)
      pub_tags = pub_tags.group_by{|u| u.title.first.mb_chars.upcase.ord }

      rus, eng = pub_tags.partition{|item| item.first > 1000 }
      rus_tags = rus.sort
      eng_tags = eng.sort

      sorted_tags = rus_tags + eng_tags
      sorted_tags = sorted_tags.map(&:last).flatten

      [ rus_tags, eng_tags, sorted_tags ]
    end
  end
end