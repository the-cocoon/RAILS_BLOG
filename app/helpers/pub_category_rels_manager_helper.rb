# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module PubCategoryRelsManagerHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        node = options[:node]
        @h, @options = h, options
        @used_in_ids = Array.wrap options[:used_in_ids]

        "
          <li data-node-id='#{ node.id }'>
            <div class='ptz_div-0 p10'>
              <div class='ptz_table w100p the-sortable-tree--item'>
                <div class='ptz_tr'>
                  <div class='ptz_td vam w30'>
                    #{ checkbox }
                  </div>

                  <div class='ptz_td vam'>
                    #{ show_link }
                  </div>

                </div>
              </div>
            </div>

            #{ children }
          </li>
        "
      end

      def checkbox
        node = options[:node]

        category_id = "pub_category_#{ node.id }"
        checked     = @used_in_ids.include?(node.id)
        klass_name  = node.class.to_s.tableize.singularize.dasherize
        classes     = "js--hub-checkbox--#{ node.id } js--#{ klass_name }-rels--checkbox"

        data        = { id: node.id, class: klass_name }

        "<div class='mr15'>
          #{ h.check_box_tag category_id, 1, checked, { autocomplete: :off, data: data, class: classes } }
          #{ h.label_tag category_id, '', for: category_id }
        </div>"
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)
        title_field = options[:title]

        "<div class='fs15'>
          #{ h.link_to node.send(title_field), url }
        </div>"
      end

      def children
        unless options[:children].blank?
          "<ol class='the-sortable-tree--nested-set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
