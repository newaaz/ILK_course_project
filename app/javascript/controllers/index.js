// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import '../custom/add_jquery'

import FotoramaController from "./fotorama_controller"
application.register("fotorama", FotoramaController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import LitePickersController from "./lite_pickers_controller"
application.register("lite-pickers", LitePickersController)

import MapsController from "./maps_controller"
application.register("maps", MapsController)

import NestedPricesController from "./nested_prices_controller"
application.register("nested-prices", NestedPricesController)

import ParallaxController from "./parallax_controller"
application.register("parallax", ParallaxController)

import PreviewsController from "./previews_controller"
application.register("previews", PreviewsController)

import PriceFromController from "./price_from_controller"
application.register("price-from", PriceFromController)

import PropertyShowController from "./property_show_controller"
application.register("property-show", PropertyShowController)

import ToastController from "./toast_controller"
application.register("toast", ToastController)
