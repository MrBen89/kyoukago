// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
import SliderController from "controllers/slider_controller"
application.register("hello", SliderController)
import TotalPriceController from "controllers/total_price_controller"
application.register("hello", TotalPriceController)
