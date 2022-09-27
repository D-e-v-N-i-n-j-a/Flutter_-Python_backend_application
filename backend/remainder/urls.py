from . import views
from django.urls import path


urlpatterns = [
    path('allTask',views.getData,name='remainder'),
    path('post-task',views.postData,name='postData'),
    path('updateTask/<str:pk>/',views.updateTask,name='updateTask'),
    path('deleteTask/<str:pk>/',views.deleteTask,name='deleteTask'),
]










