import os
import time

from flask import Flask, redirect, url_for, request, render_template
from google.cloud import pubsub_v1

app = Flask(__name__)

project_id = "distributedcomputing-290417"
topic_id = "compute-and-storage-test"

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)

futures = dict()


def get_callback(f, data):
    def callback(f):
        try:
            print(f.result())
            futures.pop(data)
        except:  # noqa
            print("Please handle {} for {}.".format(f.exception(), data))

    return callback


@app.route('/')
def hello_world():
    name = os.environ.get('NAME', 'World')
    return render_template('index.html')


@app.route('/publish', methods=['POST', 'GET'])
def publish():
    if request.method == 'POST':
        data = str(request.form['test'])
        futures.update({data: None})
        future = publisher.publish(topic_path, data.encode("utf-8"))
        futures[data] = future
        future.add_done_callback(get_callback(future, data))
        string = request.form['test']
        while futures:
            time.sleep(1)
        return redirect(url_for('success', message=string))
    else:
        string = request.args.get('test')
        return redirect(url_for('success', message=string))


@app.route('/success/<message>')
def success(message):
    return 'You typed %s' % message


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
