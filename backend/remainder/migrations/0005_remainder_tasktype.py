# Generated by Django 4.0.6 on 2022-09-26 11:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('remainder', '0004_remainder_color'),
    ]

    operations = [
        migrations.AddField(
            model_name='remainder',
            name='taskType',
            field=models.CharField(default=1, max_length=100),
            preserve_default=False,
        ),
    ]
