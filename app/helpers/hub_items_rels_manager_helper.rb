# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module HubItemsRelsManagerHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        node = options[:node]
        @h, @options   = h, options
        @used_hubs_ids = Array.wrap options[:pub_used_hubs_ids]

        "
          <li data-node-id='#{ node.id }'>
            <div class='ptz--div-0 p10'>
              <div class='ptz--table w100p the-sortable-tree--item'>
                <div class='ptz--tr'>
                  <div class='ptz--td vam w30'>
                    #{ checkbox }
                  </div>

                  <div class='ptz--td vam'>
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
        node    = options[:node]
        hub_id  = "hub_#{ node.id }"
        checked = @used_hubs_ids.include?(node.id)
        data    = { id: node.id, role: 'hub-item-rels--checkbox' }

        "<div class='mr15'>
          #{ h.check_box_tag hub_id, 1, checked, { autocomplete: :off, data: data } }
          #{ h.label_tag hub_id, '', for: hub_id }
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
