import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
    connect() {
        // Add to desired page
        // <div data-controller="hello"></div>
        const actionCableRef = createConsumer()
        actionCableRef.subscriptions.create(
            {
                channel: `DummyChannel`,
            },
            {
                received: (data) => {
                    console.log('received dummy', data)
                    this.element.textContent = JSON.stringify(data)
                }
            }
        )
        this.element.textContent = "Hello World!"
    }
}
