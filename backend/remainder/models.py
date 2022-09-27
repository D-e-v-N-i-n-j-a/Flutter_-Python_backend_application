from django.db import models

# Create your models here.


class Remainder(models.Model):
    title = models.CharField(max_length=100)
    taskType = models.CharField(max_length=100)
    description = models.TextField()
    duration = models.DateField()
    is_pinned = models.BooleanField(default=False)
    color = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    
    
    
    def __str__(self) -> str:
        return self.title
    

  
 