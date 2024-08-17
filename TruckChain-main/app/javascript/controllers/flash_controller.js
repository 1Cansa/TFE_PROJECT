import {Controller} from "@hotwired/stimulus"
import {toast} from "../utils/alert";

export default class FlashController extends Controller {
    async connect() {
        await toast(
            this.element.getAttribute('data-type'),
            this.element.getAttribute('data-message'),
            this.element.getAttribute('data-timer') || 5000
        )
    }
}
