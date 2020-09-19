from django.db import models

from wagtail.api import APIField
from wagtail.core.models import Orderable, Page
from wagtail.core.fields import RichTextField
from wagtail.admin.edit_handlers import FieldPanel
from wagtail.images.edit_handlers import ImageChooserPanel

class BlogPageAuthor(Orderable):
    page = models.ForeignKey('blog.BlogPage', on_delete=models.CASCADE, related_name='authors')
    name = models.CharField(max_length=255)

    api_fields = [
        APIField('name'),
    ]


class BlogPage(Page):
    body = RichTextField(blank=True)
    feed_image = models.ForeignKey(
        "wagtailimages.Image",
        null=True,
        blank=False,
        on_delete=models.SET_NULL,
        related_name="+"
    )
    #private_field = models.CharField(max_length=255)


    content_panels = Page.content_panels + [
        FieldPanel("body"),
        ImageChooserPanel("feed_image"),
    ]

    # Export fields over the API
    api_fields = [
        APIField('body'),
        APIField('feed_image'),
        #APIField('authors'),  # This will nest the relevant BlogPageAuthor objects in the API response
    ]
