module Polaris
  # Module to allow shorthand calls for Polaris components
  module ViewHelper
    # standard:disable Layout/HashAlignment
    POLARIS_HELPERS = {
      action_list:              "Polaris::ActionListComponent",
      autocomplete:             "Polaris::AutocompleteComponent",
      autocomplete_section:     "Polaris::Autocomplete::SectionComponent",
      autocomplete_option:      "Polaris::Autocomplete::OptionComponent",
      avatar:                   "Polaris::AvatarComponent",
      badge:                    "Polaris::BadgeComponent",
      banner:                   "Polaris::BannerComponent",
      button:                   "Polaris::ButtonComponent",
      button_group:             "Polaris::ButtonGroupComponent",
      callout_card:             "Polaris::CalloutCardComponent",
      caption:                  "Polaris::CaptionComponent",
      card:                     "Polaris::CardComponent",
      card_section:             "Polaris::Card::SectionComponent",
      checkbox:                 "Polaris::CheckboxComponent",
      check_box:                "Polaris::CheckboxComponent",
      choice_list:              "Polaris::ChoiceListComponent",
      collapsible:              "Polaris::CollapsibleComponent",
      data_table:               "Polaris::DataTableComponent",
      description_list:         "Polaris::DescriptionListComponent",
      display_text:             "Polaris::DisplayTextComponent",
      dropzone:                 "Polaris::DropzoneComponent",
      empty_search_results:     "Polaris::EmptySearchResultsComponent",
      empty_state:              "Polaris::EmptyStateComponent",
      exception_list:           "Polaris::ExceptionListComponent",
      footer_help:              "Polaris::FooterHelpComponent",
      form_layout:              "Polaris::FormLayoutComponent",
      frame:                    "Polaris::FrameComponent",
      filters:                  "Polaris::FiltersComponent",
      heading:                  "Polaris::HeadingComponent",
      icon:                     "Polaris::IconComponent",
      index_table:              "Polaris::IndexTableComponent",
      inline_error:             "Polaris::InlineErrorComponent",
      keyboard_key:             "Polaris::KeyboardKeyComponent",
      layout:                   "Polaris::LayoutComponent",
      link:                     "Polaris::LinkComponent",
      list:                     "Polaris::ListComponent",
      modal:                    "Polaris::ModalComponent",
      navigation:               "Polaris::NavigationComponent",
      option_list:              "Polaris::OptionListComponent",
      page:                     "Polaris::PageComponent",
      page_actions:             "Polaris::PageActionsComponent",
      pagination:               "Polaris::PaginationComponent",
      progress_bar:             "Polaris::ProgressBarComponent",
      popover:                  "Polaris::PopoverComponent",
      radio_button:             "Polaris::RadioButtonComponent",
      resource_list:            "Polaris::ResourceListComponent",
      resource_item:            "Polaris::ResourceItemComponent",
      select:                   "Polaris::SelectComponent",
      setting_toggle:           "Polaris::SettingToggleComponent",
      shopify_navigation:       "Polaris::ShopifyNavigationComponent",
      stack:                    "Polaris::StackComponent",
      stack_item:               "Polaris::Stack::ItemComponent",
      subheading:               "Polaris::SubheadingComponent",
      scrollable:               "Polaris::ScrollableComponent",
      spinner:                  "Polaris::SpinnerComponent",
      skeleton_body_text:       "Polaris::SkeletonBodyTextComponent",
      skeleton_display_text:    "Polaris::SkeletonDisplayTextComponent",
      skeleton_thumbnail:       "Polaris::SkeletonThumbnailComponent",
      spacer:                   "Polaris::SpacerComponent",
      tabs:                     "Polaris::TabsComponent",
      tag:                      "Polaris::TagComponent",
      text_container:           "Polaris::TextContainerComponent",
      text_field:               "Polaris::TextFieldComponent",
      text_style:               "Polaris::TextStyleComponent",
      thumbnail:                "Polaris::ThumbnailComponent",
      toast:                    "Polaris::ToastComponent",
      visually_hidden:          "Polaris::VisuallyHiddenComponent"
    }.freeze
    # standard:enable Layout/HashAlignment
    POLARIS_HELPERS.each do |name, component|
      define_method "polaris_#{name}" do |*args, **kwargs, &block|
        render component.constantize.new(*args, **kwargs), &block
      end
    end

    POLARIS_TEXT_STYLES = %i[subdued strong positive negative code].freeze
    POLARIS_TEXT_STYLES.each do |name|
      define_method "polaris_text_#{name}" do |**kwargs, &block|
        polaris_text_style(variation: name, **kwargs, &block)
      end
    end

    def polaris_icon_source(name)
      path = ViewComponents::Engine.root.join("app", "assets", "icons", "polaris", "#{name}.svg")
      file = File.read(path)
      doc = Nokogiri::HTML::DocumentFragment.parse(file)
      svg = doc.at_css "svg"
      svg[:class] = "Polaris-Icon__Svg"
      svg[:focusable] = false
      svg[:"aria-hidden"] = true
      doc.to_html.html_safe
    end

    def polaris_body_styles
      %(background-color: rgb(246, 246, 247); color: rgb(32, 34, 35); --p-background:rgba(246, 246, 247, 1); --p-background-hovered:rgba(241, 242, 243, 1); --p-background-pressed:rgba(237, 238, 239, 1); --p-background-selected:rgba(237, 238, 239, 1); --p-surface:rgba(255, 255, 255, 1); --p-surface-neutral:rgba(228, 229, 231, 1); --p-surface-neutral-hovered:rgba(219, 221, 223, 1); --p-surface-neutral-pressed:rgba(201, 204, 208, 1); --p-surface-neutral-disabled:rgba(241, 242, 243, 1); --p-surface-neutral-subdued:rgba(246, 246, 247, 1); --p-surface-subdued:rgba(250, 251, 251, 1); --p-surface-disabled:rgba(250, 251, 251, 1); --p-surface-hovered:rgba(246, 246, 247, 1); --p-surface-pressed:rgba(241, 242, 243, 1); --p-surface-depressed:rgba(237, 238, 239, 1); --p-backdrop:rgba(0, 0, 0, 0.5); --p-overlay:rgba(255, 255, 255, 0.5); --p-shadow-from-dim-light:rgba(0, 0, 0, 0.2); --p-shadow-from-ambient-light:rgba(23, 24, 24, 0.05); --p-shadow-from-direct-light:rgba(0, 0, 0, 0.15); --p-hint-from-direct-light:rgba(0, 0, 0, 0.15); --p-on-surface-background:rgba(241, 242, 243, 1); --p-border:rgba(140, 145, 150, 1); --p-border-neutral-subdued:rgba(186, 191, 195, 1); --p-border-hovered:rgba(153, 158, 164, 1); --p-border-disabled:rgba(210, 213, 216, 1); --p-border-subdued:rgba(201, 204, 207, 1); --p-border-depressed:rgba(87, 89, 89, 1); --p-border-shadow:rgba(174, 180, 185, 1); --p-border-shadow-subdued:rgba(186, 191, 196, 1); --p-divider:rgba(225, 227, 229, 1); --p-icon:rgba(92, 95, 98, 1); --p-icon-hovered:rgba(26, 28, 29, 1); --p-icon-pressed:rgba(68, 71, 74, 1); --p-icon-disabled:rgba(186, 190, 195, 1); --p-icon-subdued:rgba(140, 145, 150, 1); --p-text:rgba(32, 34, 35, 1); --p-text-disabled:rgba(140, 145, 150, 1); --p-text-subdued:rgba(109, 113, 117, 1); --p-interactive:rgba(44, 110, 203, 1); --p-interactive-disabled:rgba(189, 193, 204, 1); --p-interactive-hovered:rgba(31, 81, 153, 1); --p-interactive-pressed:rgba(16, 50, 98, 1); --p-focused:rgba(69, 143, 255, 1); --p-surface-selected:rgba(242, 247, 254, 1); --p-surface-selected-hovered:rgba(237, 244, 254, 1); --p-surface-selected-pressed:rgba(229, 239, 253, 1); --p-icon-on-interactive:rgba(255, 255, 255, 1); --p-text-on-interactive:rgba(255, 255, 255, 1); --p-action-secondary:rgba(255, 255, 255, 1); --p-action-secondary-disabled:rgba(255, 255, 255, 1); --p-action-secondary-hovered:rgba(246, 246, 247, 1); --p-action-secondary-pressed:rgba(241, 242, 243, 1); --p-action-secondary-depressed:rgba(109, 113, 117, 1); --p-action-primary:rgba(0, 128, 96, 1); --p-action-primary-disabled:rgba(241, 241, 241, 1); --p-action-primary-hovered:rgba(0, 110, 82, 1); --p-action-primary-pressed:rgba(0, 94, 70, 1); --p-action-primary-depressed:rgba(0, 61, 44, 1); --p-icon-on-primary:rgba(255, 255, 255, 1); --p-text-on-primary:rgba(255, 255, 255, 1); --p-text-primary:rgba(0, 123, 92, 1); --p-text-primary-hovered:rgba(0, 108, 80, 1); --p-text-primary-pressed:rgba(0, 92, 68, 1); --p-surface-primary-selected:rgba(241, 248, 245, 1); --p-surface-primary-selected-hovered:rgba(179, 208, 195, 1); --p-surface-primary-selected-pressed:rgba(162, 188, 176, 1); --p-border-critical:rgba(253, 87, 73, 1); --p-border-critical-subdued:rgba(224, 179, 178, 1); --p-border-critical-disabled:rgba(255, 167, 163, 1); --p-icon-critical:rgba(215, 44, 13, 1); --p-surface-critical:rgba(254, 211, 209, 1); --p-surface-critical-subdued:rgba(255, 244, 244, 1); --p-surface-critical-subdued-hovered:rgba(255, 240, 240, 1); --p-surface-critical-subdued-pressed:rgba(255, 233, 232, 1); --p-surface-critical-subdued-depressed:rgba(254, 188, 185, 1); --p-text-critical:rgba(215, 44, 13, 1); --p-action-critical:rgba(216, 44, 13, 1); --p-action-critical-disabled:rgba(241, 241, 241, 1); --p-action-critical-hovered:rgba(188, 34, 0, 1); --p-action-critical-pressed:rgba(162, 27, 0, 1); --p-action-critical-depressed:rgba(108, 15, 0, 1); --p-icon-on-critical:rgba(255, 255, 255, 1); --p-text-on-critical:rgba(255, 255, 255, 1); --p-interactive-critical:rgba(216, 44, 13, 1); --p-interactive-critical-disabled:rgba(253, 147, 141, 1); --p-interactive-critical-hovered:rgba(205, 41, 12, 1); --p-interactive-critical-pressed:rgba(103, 15, 3, 1); --p-border-warning:rgba(185, 137, 0, 1); --p-border-warning-subdued:rgba(225, 184, 120, 1); --p-icon-warning:rgba(185, 137, 0, 1); --p-surface-warning:rgba(255, 215, 157, 1); --p-surface-warning-subdued:rgba(255, 245, 234, 1); --p-surface-warning-subdued-hovered:rgba(255, 242, 226, 1); --p-surface-warning-subdued-pressed:rgba(255, 235, 211, 1); --p-text-warning:rgba(145, 106, 0, 1); --p-border-highlight:rgba(68, 157, 167, 1); --p-border-highlight-subdued:rgba(152, 198, 205, 1); --p-icon-highlight:rgba(0, 160, 172, 1); --p-surface-highlight:rgba(164, 232, 242, 1); --p-surface-highlight-subdued:rgba(235, 249, 252, 1); --p-surface-highlight-subdued-hovered:rgba(228, 247, 250, 1); --p-surface-highlight-subdued-pressed:rgba(213, 243, 248, 1); --p-text-highlight:rgba(52, 124, 132, 1); --p-border-success:rgba(0, 164, 124, 1); --p-border-success-subdued:rgba(149, 201, 180, 1); --p-icon-success:rgba(0, 127, 95, 1); --p-surface-success:rgba(174, 233, 209, 1); --p-surface-success-subdued:rgba(241, 248, 245, 1); --p-surface-success-subdued-hovered:rgba(236, 246, 241, 1); --p-surface-success-subdued-pressed:rgba(226, 241, 234, 1); --p-text-success:rgba(0, 128, 96, 1); --p-decorative-one-icon:rgba(126, 87, 0, 1); --p-decorative-one-surface:rgba(255, 201, 107, 1); --p-decorative-one-text:rgba(61, 40, 0, 1); --p-decorative-two-icon:rgba(175, 41, 78, 1); --p-decorative-two-surface:rgba(255, 196, 176, 1); --p-decorative-two-text:rgba(73, 11, 28, 1); --p-decorative-three-icon:rgba(0, 109, 65, 1); --p-decorative-three-surface:rgba(146, 230, 181, 1); --p-decorative-three-text:rgba(0, 47, 25, 1); --p-decorative-four-icon:rgba(0, 106, 104, 1); --p-decorative-four-surface:rgba(145, 224, 214, 1); --p-decorative-four-text:rgba(0, 45, 45, 1); --p-decorative-five-icon:rgba(174, 43, 76, 1); --p-decorative-five-surface:rgba(253, 201, 208, 1); --p-decorative-five-text:rgba(79, 14, 31, 1); --p-border-radius-base:0.4rem; --p-border-radius-wide:0.8rem; --p-border-radius-full:50%; --p-card-shadow:0px 0px 5px var(--p-shadow-from-ambient-light), 0px 1px 2px var(--p-shadow-from-direct-light); --p-popover-shadow:-1px 0px 20px var(--p-shadow-from-ambient-light), 0px 1px 5px var(--p-shadow-from-direct-light); --p-modal-shadow:0px 26px 80px var(--p-shadow-from-dim-light), 0px 0px 1px var(--p-shadow-from-dim-light); --p-top-bar-shadow:0 2px 2px -1px var(--p-shadow-from-direct-light); --p-button-drop-shadow:0 1px 0 rgba(0, 0, 0, 0.05); --p-button-inner-shadow:inset 0 -1px 0 rgba(0, 0, 0, 0.2); --p-button-pressed-inner-shadow:inset 0 1px 0 rgba(0, 0, 0, 0.15); --p-override-none:none; --p-override-transparent:transparent; --p-override-one:1; --p-override-visible:visible; --p-override-zero:0; --p-override-loading-z-index:514; --p-button-font-weight:500; --p-non-null-content:''; --p-choice-size:2rem; --p-icon-size:1rem; --p-choice-margin:0.1rem; --p-control-border-width:0.2rem; --p-banner-border-default:inset 0 0.1rem 0 0 var(--p-border-neutral-subdued), inset 0 0 0 0.1rem var(--p-border-neutral-subdued); --p-banner-border-success:inset 0 0.1rem 0 0 var(--p-border-success-subdued), inset 0 0 0 0.1rem var(--p-border-success-subdued); --p-banner-border-highlight:inset 0 0.1rem 0 0 var(--p-border-highlight-subdued), inset 0 0 0 0.1rem var(--p-border-highlight-subdued); --p-banner-border-warning:inset 0 0.1rem 0 0 var(--p-border-warning-subdued), inset 0 0 0 0.1rem var(--p-border-warning-subdued); --p-banner-border-critical:inset 0 0.1rem 0 0 var(--p-border-critical-subdued), inset 0 0 0 0.1rem var(--p-border-critical-subdued); --p-badge-mix-blend-mode:luminosity; --p-thin-border-subdued:0.1rem solid var(--p-border-subdued); --p-text-field-spinner-offset:0.2rem; --p-text-field-focus-ring-offset:-0.4rem; --p-text-field-focus-ring-border-radius:0.7rem; --p-button-group-item-spacing:-0.1rem; --p-duration-1-0-0:100ms; --p-duration-1-5-0:150ms; --p-ease-in:cubic-bezier(0.5, 0.1, 1, 1); --p-ease:cubic-bezier(0.4, 0.22, 0.28, 1); --p-range-slider-thumb-size-base:1.6rem; --p-range-slider-thumb-size-active:2.4rem; --p-range-slider-thumb-scale:1.5; --p-badge-font-weight:400; --p-frame-offset:0px;)
    end

    def polaris_inversed_colors
      %(--p-background:rgba(11, 12, 13, 1); --p-background-hovered:rgba(11, 12, 13, 1); --p-background-pressed:rgba(11, 12, 13, 1); --p-background-selected:rgba(11, 12, 13, 1); --p-surface:rgba(32, 33, 35, 1); --p-surface-neutral:rgba(49, 51, 53, 1); --p-surface-neutral-hovered:rgba(49, 51, 53, 1); --p-surface-neutral-pressed:rgba(49, 51, 53, 1); --p-surface-neutral-disabled:rgba(49, 51, 53, 1); --p-surface-neutral-subdued:rgba(68, 71, 74, 1); --p-surface-subdued:rgba(26, 28, 29, 1); --p-surface-disabled:rgba(26, 28, 29, 1); --p-surface-hovered:rgba(47, 49, 51, 1); --p-surface-pressed:rgba(62, 64, 67, 1); --p-surface-depressed:rgba(80, 83, 86, 1); --p-surface-search-field:rgba(47, 49, 51, 1); --p-backdrop:rgba(0, 0, 0, 0.5); --p-overlay:rgba(33, 33, 33, 0.5); --p-shadow-from-dim-light:rgba(255, 255, 255, 0.2); --p-shadow-from-ambient-light:rgba(23, 24, 24, 0.05); --p-shadow-from-direct-light:rgba(255, 255, 255, 0.15); --p-hint-from-direct-light:rgba(185, 185, 185, 0.2); --p-border:rgba(80, 83, 86, 1); --p-border-neutral-subdued:rgba(130, 135, 139, 1); --p-border-hovered:rgba(80, 83, 86, 1); --p-border-disabled:rgba(103, 107, 111, 1); --p-border-subdued:rgba(130, 135, 139, 1); --p-border-depressed:rgba(142, 145, 145, 1); --p-border-shadow:rgba(91, 95, 98, 1); --p-border-shadow-subdued:rgba(130, 135, 139, 1); --p-divider:rgba(69, 71, 73, 1); --p-icon:rgba(166, 172, 178, 1); --p-icon-hovered:rgba(225, 227, 229, 1); --p-icon-pressed:rgba(166, 172, 178, 1); --p-icon-disabled:rgba(84, 87, 90, 1); --p-icon-subdued:rgba(120, 125, 129, 1); --p-text:rgba(227, 229, 231, 1); --p-text-disabled:rgba(111, 115, 119, 1); --p-text-subdued:rgba(153, 159, 164, 1); --p-interactive:rgba(54, 163, 255, 1); --p-interactive-disabled:rgba(38, 98, 182, 1); --p-interactive-hovered:rgba(103, 175, 255, 1); --p-interactive-pressed:rgba(136, 188, 255, 1); --p-icon-interactive:rgba(54, 163, 255, 1); --p-focused:rgba(38, 98, 182, 1); --p-surface-selected:rgba(2, 14, 35, 1); --p-surface-selected-hovered:rgba(7, 29, 61, 1); --p-surface-selected-pressed:rgba(13, 43, 86, 1); --p-icon-on-interactive:rgba(255, 255, 255, 1); --p-text-on-interactive:rgba(255, 255, 255, 1); --p-action-secondary:rgba(77, 80, 83, 1); --p-action-secondary-disabled:rgba(32, 34, 35, 1); --p-action-secondary-hovered:rgba(84, 87, 91, 1); --p-action-secondary-pressed:rgba(96, 100, 103, 1); --p-action-secondary-depressed:rgba(123, 127, 132, 1); --p-action-primary:rgba(0, 128, 96, 1); --p-action-primary-disabled:rgba(0, 86, 64, 1); --p-action-primary-hovered:rgba(0, 150, 113, 1); --p-action-primary-pressed:rgba(0, 164, 124, 1); --p-action-primary-depressed:rgba(0, 179, 136, 1); --p-icon-on-primary:rgba(230, 255, 244, 1); --p-text-on-primary:rgba(255, 255, 255, 1); --p-text-primary:rgba(0, 141, 106, 1); --p-text-primary-hovered:rgba(0, 158, 120, 1); --p-text-primary-pressed:rgba(0, 176, 133, 1); --p-surface-primary-selected:rgba(12, 18, 16, 1); --p-surface-primary-selected-hovered:rgba(40, 48, 44, 1); --p-surface-primary-selected-pressed:rgba(54, 64, 59, 1); --p-border-critical:rgba(227, 47, 14, 1); --p-border-critical-subdued:rgba(227, 47, 14, 1); --p-border-critical-disabled:rgba(131, 23, 4, 1); --p-icon-critical:rgba(218, 45, 13, 1); --p-surface-critical:rgba(69, 7, 1, 1); --p-surface-critical-subdued:rgba(69, 7, 1, 1); --p-surface-critical-subdued-hovered:rgba(68, 23, 20, 1); --p-surface-critical-subdued-pressed:rgba(107, 16, 3, 1); --p-surface-critical-subdued-depressed:rgba(135, 24, 5, 1); --p-text-critical:rgba(233, 128, 122, 1); --p-action-critical:rgba(205, 41, 12, 1); --p-action-critical-disabled:rgba(187, 37, 10, 1); --p-action-critical-hovered:rgba(227, 47, 14, 1); --p-action-critical-pressed:rgba(250, 53, 17, 1); --p-action-critical-depressed:rgba(253, 87, 73, 1); --p-icon-on-critical:rgba(255, 248, 247, 1); --p-text-on-critical:rgba(255, 255, 255, 1); --p-interactive-critical:rgba(253, 114, 106, 1); --p-interactive-critical-disabled:rgba(254, 172, 168, 1); --p-interactive-critical-hovered:rgba(253, 138, 132, 1); --p-interactive-critical-pressed:rgba(253, 159, 155, 1); --p-border-warning:rgba(153, 112, 0, 1); --p-border-warning-subdued:rgba(153, 112, 0, 1); --p-icon-warning:rgba(104, 75, 0, 1); --p-surface-warning:rgba(153, 112, 0, 1); --p-surface-warning-subdued:rgba(77, 59, 29, 1); --p-surface-warning-subdued-hovered:rgba(82, 63, 32, 1); --p-surface-warning-subdued-pressed:rgba(87, 67, 34, 1); --p-text-warning:rgba(202, 149, 0, 1); --p-border-highlight:rgba(68, 157, 167, 1); --p-border-highlight-subdued:rgba(68, 157, 167, 1); --p-icon-highlight:rgba(44, 108, 115, 1); --p-surface-highlight:rgba(0, 105, 113, 1); --p-surface-highlight-subdued:rgba(18, 53, 57, 1); --p-surface-highlight-subdued-hovered:rgba(20, 58, 62, 1); --p-surface-highlight-subdued-pressed:rgba(24, 65, 70, 1); --p-text-highlight:rgba(162, 239, 250, 1); --p-border-success:rgba(0, 135, 102, 1); --p-border-success-subdued:rgba(0, 135, 102, 1); --p-icon-success:rgba(0, 94, 70, 1); --p-surface-success:rgba(0, 94, 70, 1); --p-surface-success-subdued:rgba(28, 53, 44, 1); --p-surface-success-subdued-hovered:rgba(31, 58, 48, 1); --p-surface-success-subdued-pressed:rgba(35, 65, 54, 1); --p-text-success:rgba(88, 173, 142, 1); --p-decorative-one-icon:rgba(255, 186, 67, 1); --p-decorative-one-surface:rgba(142, 102, 9, 1); --p-decorative-one-text:rgba(255, 255, 255, 1); --p-decorative-two-icon:rgba(245, 182, 192, 1); --p-decorative-two-surface:rgba(206, 88, 20, 1); --p-decorative-two-text:rgba(255, 255, 255, 1); --p-decorative-three-icon:rgba(0, 227, 141, 1); --p-decorative-three-surface:rgba(0, 124, 90, 1); --p-decorative-three-text:rgba(255, 255, 255, 1); --p-decorative-four-icon:rgba(0, 221, 218, 1); --p-decorative-four-surface:rgba(22, 124, 121, 1); --p-decorative-four-text:rgba(255, 255, 255, 1); --p-decorative-five-icon:rgba(244, 183, 191, 1); --p-decorative-five-surface:rgba(194, 51, 86, 1); --p-decorative-five-text:rgba(255, 255, 255, 1); --p-border-radius-slim:0.2rem; --p-border-radius-base:0.4rem; --p-border-radius-wide:0.8rem; --p-border-radius-full:50%; --p-card-shadow:0px 0px 5px var(--p-shadow-from-ambient-light), 0px 1px 2px var(--p-shadow-from-direct-light); --p-popover-shadow:-1px 0px 20px var(--p-shadow-from-ambient-light), 0px 1px 5px var(--p-shadow-from-direct-light); --p-modal-shadow:0px 26px 80px var(--p-shadow-from-dim-light), 0px 0px 1px var(--p-shadow-from-dim-light); --p-top-bar-shadow:0 2px 2px -1px var(--p-shadow-from-direct-light); --p-button-drop-shadow:0 1px 0 rgba(0, 0, 0, 0.05); --p-button-inner-shadow:inset 0 -1px 0 rgba(0, 0, 0, 0.2); --p-button-pressed-inner-shadow:inset 0 1px 0 rgba(0, 0, 0, 0.15); --p-override-none:none; --p-override-transparent:transparent; --p-override-one:1; --p-override-visible:visible; --p-override-zero:0; --p-override-loading-z-index:514; --p-button-font-weight:500; --p-non-null-content:""; --p-choice-size:2rem; --p-icon-size:1rem; --p-choice-margin:0.1rem; --p-control-border-width:0.2rem; --p-banner-border-default:inset 0 0.1rem 0 0 var(--p-border-neutral-subdued), inset 0 0 0 0.1rem var(--p-border-neutral-subdued); --p-banner-border-success:inset 0 0.1rem 0 0 var(--p-border-success-subdued), inset 0 0 0 0.1rem var(--p-border-success-subdued); --p-banner-border-highlight:inset 0 0.1rem 0 0 var(--p-border-highlight-subdued), inset 0 0 0 0.1rem var(--p-border-highlight-subdued); --p-banner-border-warning:inset 0 0.1rem 0 0 var(--p-border-warning-subdued), inset 0 0 0 0.1rem var(--p-border-warning-subdued); --p-banner-border-critical:inset 0 0.1rem 0 0 var(--p-border-critical-subdued), inset 0 0 0 0.1rem var(--p-border-critical-subdued); --p-badge-mix-blend-mode:luminosity; --p-thin-border-subdued:0.1rem solid var(--p-border-subdued); --p-text-field-spinner-offset:0.2rem; --p-text-field-focus-ring-offset:-0.4rem; --p-text-field-focus-ring-border-radius:0.7rem; --p-button-group-item-spacing:-0.1rem; --p-duration-1-0-0:100ms; --p-duration-1-5-0:150ms; --p-ease-in:cubic-bezier(0.5, 0.1, 1, 1); --p-ease:cubic-bezier(0.4, 0.22, 0.28, 1); --p-range-slider-thumb-size-base:1.6rem; --p-range-slider-thumb-size-active:2.4rem; --p-range-slider-thumb-scale:1.5; --p-badge-font-weight:400; --p-frame-offset:0px; color: rgb(227, 229, 231);)
    end
  end
end
