from firebase_functions import https_fn, options
from firebase_admin import initialize_app
from firebase_admin import firestore
from firebase_admin import messaging

initialize_app()

# set max instances to 1
options.set_global_options(max_instances=10)

@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")

# write a function to send a push notification, load the title and the data from the post request
# send the request to user_id, which is in the post request, connect to firestore and read fcm_token for that particular user
# send the push notification to that user
@https_fn.on_request()
def send_push_notification(req: https_fn.Request) -> https_fn.Response:

    import json

    data = req.get_json()
    title = data.get('title')
    message = data.get('message')

    db = firestore.client()
  
    # see if request has a user email, id 
    user_id = data.get('user_id')
    user_ref = db.collection('users').document(user_id)
    user = user_ref.get()
    fcm_token = user.get('fcm_token')
    

    message = messaging.Message(
        notification=messaging.Notification(title=title, body=message),
        token=fcm_token
    )

    response = messaging.send(message)
    return https_fn.Response(json.dumps(response))