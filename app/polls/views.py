from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse


def index(request):
    latest_question_list = [{ "id": "1", "question_text": "Some link" }]
    template = loader.get_template('polls/index.html')
    context = {
        'latest_question_list': latest_question_list,
    }
    return HttpResponse(template.render(context, request))