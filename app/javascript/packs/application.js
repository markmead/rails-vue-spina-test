import Rails from '@rails/ujs'
import * as ActiveStorage from '@rails/activestorage'
import Turbolinks from 'turbolinks'

import 'typeface-roboto'
import '../css/application.scss'

Rails.start()
ActiveStorage.start()
Turbolinks.start()
