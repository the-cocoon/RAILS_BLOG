module PubTagsHelper
  def pub_tags_sorted_list
    @pub_tags_list ||= PubTagViewModel.get
  end
end