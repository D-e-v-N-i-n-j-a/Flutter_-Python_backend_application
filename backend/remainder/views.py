from django.shortcuts import render
from django.http import JsonResponse
from .models import Remainder
from .serializers import RemainderSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
# Create your views here.
 
@api_view(['GET',])
def getData(request):
    # GET ALL TASK HERE 
    task = Remainder.objects.all()
    # SERIALIZE THEM
    serializer = RemainderSerializer(task,many=True)
    # RETURN A JSON 
    
    return JsonResponse({'data':serializer.data},safe=False)
    
    

@api_view(['POST'])
def postData(request):
    serializer = RemainderSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    # return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
    



@api_view(['PUT'])
def updateTask(request, pk):
    task = Remainder.objects.get(id=pk)
    serializer = RemainderSerializer(task,data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
 


@api_view(['DELETE'])
def deleteTask(request,pk):
    task = Remainder.objects.get(id=pk)
    task.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)
    





