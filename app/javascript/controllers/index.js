// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FilterController from "./filter_controller"
application.register("filter", FilterController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import QaCardController from "./qa_card_controller"
application.register("qa-card", QaCardController)

import QuizController from "./quiz_controller"
application.register("quiz", QuizController)

import MenuController from "./menu_controller"
application.register("menu", MenuController)