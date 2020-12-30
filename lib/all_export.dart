//all screen export
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'dart:convert';
export 'package:multi_image_picker/multi_image_picker.dart';

export 'package:provider/provider.dart';

// Standart Library
export 'package:flutter/services.dart';
export 'dart:async';

// NonStandard Library
export 'package:flare_flutter/flare_actor.dart';
export 'package:flare_flutter/flare_controller.dart';

// core
export 'package:selendra_marketplace_app/core/backend/api.dart';
export 'package:selendra_marketplace_app/core/backend/post/post_request.dart';
export 'package:selendra_marketplace_app/core/backend/get/get_request.dart';

export 'package:selendra_marketplace_app/core/backend/component.dart';
export 'package:selendra_marketplace_app/core/storage/storage.dart';

export 'package:http_parser/http_parser.dart';
export 'dart:io';

//Pubspac
export 'package:flutter_svg/svg.dart';

//Validate Mixin
export 'package:selendra_marketplace_app/core/services/validator_mixin.dart';

//Components
export 'package:selendra_marketplace_app/core/components/flare_animation_c.dart';
export 'package:selendra_marketplace_app/ui/component.dart';
export 'package:selendra_marketplace_app/core/components/trx_option_c.dart';
export 'package:selendra_marketplace_app/core/components/bottom_sheet_c.dart';
export 'package:pinput/pin_put/pin_put.dart';
export 'package:selendra_marketplace_app/core/components/app_bar_c.dart';
export 'package:selendra_marketplace_app/core/components/my_input.dart';
export 'package:selendra_marketplace_app/core/components/dropdown_c.dart';
export 'package:selendra_marketplace_app/core/components/text_c.dart';
export 'package:selendra_marketplace_app/core/components/snackBar_c.dart';
export 'package:selendra_marketplace_app/core/components/body_scaffold_c.dart';
export 'package:selendra_marketplace_app/core/components/item_list.dart';

// Transaction
export 'package:permission_handler/permission_handler.dart';
export 'package:selendra_marketplace_app/ui/screens/wallet/submit_trx/submit_trx.dart';
export 'package:selendra_marketplace_app/ui/screens/wallet/submit_trx/fill_pin_dialog.dart';
export 'package:selendra_marketplace_app/ui/screens/wallet/submit_trx/submit_trx_body.dart';

// Utility Apps
export 'package:selendra_marketplace_app/core/utils/app_utils.dart';

export 'package:selendra_marketplace_app/ui/screens/wallet/submit_trx/submit_trx.dart';

//main
export 'main.dart';

//seller confirmation
export 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';

//bottom navigation
export 'ui/reuse_widget/bottom_navigation.dart';

//add listing screen
export 'ui/screens/addlisting/add_listing.dart';
export 'ui/screens/addlisting/fill_seller/fill_seller.dart';
export 'ui/screens/addlisting/components/image_list.dart';

//listing screen
export 'ui/screens/listing/listing_screen.dart';

export 'core/animation_styles/hover.dart';

//cart screen
export 'ui/screens/cart/cart.dart';
export 'ui/screens/cart/components/cart_btn_qty.dart';
export 'ui/screens/cart/components/checkout_card.dart';
export 'ui/screens/cart/components/dismissable_background.dart';

//checkout screen
export 'ui/screens/checkout/checkout.dart';
export 'ui/screens/checkout/components/order_confirmation.dart';
export 'ui/screens/checkout/components/payment_method.dart';
export 'ui/screens/checkout/components/total_price_card.dart';
export 'ui/screens/checkout/components/product_display.dart';
export 'ui/screens/checkout/components/item_order.dart';

//categories screen
export 'ui/screens/category/categories.dart';
export 'ui/screens/category/categories_list.dart';
export 'ui/screens/category/food/food_categories.dart';
export 'ui/screens/category/food/foods_screen.dart';

//detail screen
export 'ui/screens/detail/detail_screen.dart';
export 'ui/screens/detail/components/btn_qty.dart';
export 'ui/screens/detail/components/btn_add_to_cart.dart';
export 'ui/screens/detail/components/circle_shape_btn.dart';
export 'ui/screens/detail/components/sell_info.dart';
export 'ui/screens/detail/components/related_product.dart';

//favorite screen
export 'ui/screens/favorite/favorite_screen.dart';

//home screen
export 'ui/screens/home/home_screen.dart';
export 'ui/screens/home/components/drop_down_button.dart';
export 'ui/screens/home/components/search_bar.dart';
export 'ui/screens/home/components/home_drawer.dart';
export 'ui/screens/home/components/search.dart';
export 'ui/screens/home/components/home_dialog.dart';

//map screen
export 'ui/screens/map/map.dart';
export 'ui/screens/map/components/type_head.dart';
export 'ui/screens/map/components/expandable_content.dart';
export 'ui/screens/map/components/zoom_buttons.dart';
export 'ui/screens/map/components/persistent_header.dart';

//otp screen
export 'ui/screens/otp/otp.dart';

//profile screen
export 'ui/screens/profile/profile_screen.dart';
export 'ui/screens/profile/components/profile_dialog.dart';
export 'ui/screens/profile/components/profile_form.dart';
export 'ui/screens/profile/components/gender_dropdown.dart';

//cart item
export 'ui/screens/cart/components/cart_items.dart';
export 'ui/screens/cart/components/cart_btn_qty.dart';
export 'ui/screens/cart/components/dismissable_background.dart';
export 'ui/screens/cart/components/checkout_card.dart';

//purchase screen
export 'ui/screens/purchase/purchase_screen.dart';
export 'ui/screens/purchase/components/order_detail.dart';

//transaction view
export 'ui/screens/transaction/transaction_history.dart';

export 'ui/screens/seller_profile/seller_profile.dart';
//reset screen
export 'ui/screens/resetpass/reset_by_email/reset_by_email.dart';
export 'ui/screens/resetpass/reset_by_phone/reset_pass_phone.dart';
export 'ui/screens/resetpass/reset_by_phone/reset_phone_form.dart';

//sale screen
export 'ui/screens/sales/sale_screen.dart';

//setting screen
export 'ui/screens/setting/setting_screen.dart';
export 'ui/screens/setting/components/lang.dart';
export 'ui/screens/setting/components/reset_choice.dart';

//sign in screen
export 'ui/screens/signin/signin.dart';
export 'ui/screens/signin/components/signin_email_form.dart';
export 'ui/screens/signin/components/signin_phone_form.dart';

//sign in desktop screen
export 'ui/screens/signin/components/signin_email_desktop.dart';
export 'ui/screens/signin/components/signin_phone_desktop.dart';

//sign up screen
export 'ui/screens/signup/signup.dart';
export 'ui/screens/signup/components/signup_email_form.dart';
export 'ui/screens/signup/components/signup_phone_form.dart';
export 'ui/screens/signup/components/signup_phone_desktiop.dart';

//user info
export 'ui/screens/signup/userinfo/user_info.dart';

//splash screen
export 'ui/screens/splashscreen/splashscreen.dart';

//wallet screen
export 'ui/screens/wallet/wallet_screen.dart';
export 'ui/screens/wallet/get_wallet/wallet_pin.dart';
export 'ui/screens/wallet/my_wallet/my_wallet.dart';
export 'ui/screens/wallet/get_wallet/info_row.dart';
export 'ui/screens/wallet/components/wallet_choice.dart';
export 'ui/screens/wallet/get_wallet/dialog.dart';
export 'ui/screens/wallet/my_wallet/my_qr.dart';
export 'package:qr_code_scanner/qr_code_scanner.dart';

//chat screen
export 'ui/screens/chat/chat.dart';

//welcoexport 'ui/screens/welcome/welcome_screen.dart';me screen
export 'ui/screens//welcome/welcome_screen.dart';

//route
export 'core/animation_styles/route_animation.dart';

//style
export 'core/animation_styles/dark_mode_style.dart';

//intro screen
export 'ui/screens/intro/intro_screen.dart';

//notification screen
export 'ui/screens/notification/notification_screen.dart';

//reuse widget
export 'ui/reuse_widget/reuse_btn_social.dart';
export 'ui/reuse_widget/reuse_appbar.dart';
export 'ui/reuse_widget/reuse_auth_tab.dart';
export 'ui/reuse_widget/reuse_button.dart';
export 'ui/reuse_widget/reuse_flat_button.dart';
export 'ui/reuse_widget/reuse_itemcard.dart';
export 'ui/reuse_widget/reuse_pw_field.dart';
export 'ui/reuse_widget/reuse_tabbar.dart';
export 'ui/reuse_widget/reuse_text_field.dart';
export 'ui/reuse_widget/reuse.inkwell.dart';
export 'ui/reuse_widget/reuse_simple_appbar.dart';
export 'ui/reuse_widget/reuse_keyboard_num.dart';
export 'ui/reuse_widget/reuse_pin_num.dart';
export 'ui/reuse_widget/reuse_pin_animate.dart';
export 'ui/reuse_widget/reuse_alert_dialog.dart';
export 'ui/reuse_widget/reuse_num_pad.dart';
export 'ui/reuse_widget/reuse_dropdown.dart';
export 'ui/reuse_widget/reuse_btn_qty.dart';
export 'ui/reuse_widget/reuse_search_field.dart';
export 'ui/reuse_widget/reuse_phone_field.dart';
export 'ui/reuse_widget/product_list.dart';
export 'ui/reuse_widget/item_card.dart';
export 'ui/reuse_widget/individual_chat.dart';
export 'ui/reuse_widget/reuse_icon_badge.dart';
export 'ui/reuse_widget/reuse_qr_card.dart';
export 'ui/reuse_widget/network_alert.dart';
export 'ui/reuse_widget/reuse_indicator.dart';
export 'ui/reuse_widget/reuse_flexspace.dart';
export 'ui/reuse_widget/reuse_reset_form.dart';
export 'ui/reuse_widget/reuse_desktop.dart';
export 'ui/reuse_widget/responsive_widget.dart';

//enums
export 'core/enums/connectivity_status.dart';

//constant
export 'core/constants/constants.dart';

//provider
export 'core/providers/cart_provider.dart';
export 'core/providers/favorite_provider.dart';
export 'core/providers/products_provider.dart';
export 'core/providers/lang_provider.dart';
export 'core/providers/user_provider.dart';
export 'core/providers/auth_provider.dart';
export 'core/providers/trx_history_provider.dart';
export 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
export 'core/providers/add_product_provider.dart';
export 'core/providers/dark_mode_provider.dart';

//models
export 'core/models/api_url.dart';
export 'core/models/categories.dart';
export 'core/models/products.dart';
export 'core/models/user.dart';
export 'core/models/wallet.dart';
export 'core/models/acc_balance.dart';
export 'core/models/wallet_response.dart';
export 'core/models/notification_model.dart';
export 'core/models/add_product_m.dart';
export 'core/models/product_image.dart';
export 'package:selendra_marketplace_app/core/models/scan_pay_m.dart';
export 'package:selendra_marketplace_app/core/models/trx_history_m.dart';

//services
export 'core/services/auth/api_post_services.dart';
export 'core/services/auth/api_get_services.dart';
export 'core/services/auth/auth_services.dart';
export 'core/services/connectivity_services.dart';
export 'core/services/pref_service.dart';
export 'core/services/app_localize_service.dart';
export 'core/services/app_services.dart';
