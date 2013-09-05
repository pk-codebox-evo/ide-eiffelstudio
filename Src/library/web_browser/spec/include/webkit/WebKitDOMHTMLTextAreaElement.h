/*
    This file is part of the WebKit open source project.
    This file has been generated by generate-bindings.pl. DO NOT MODIFY!

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef WebKitDOMHTMLTextAreaElement_h
#define WebKitDOMHTMLTextAreaElement_h

#include "webkit/webkitdomdefines.h"
#include <glib-object.h>
#include <webkit/webkitdefines.h>
#include "webkit/WebKitDOMHTMLElement.h"


G_BEGIN_DECLS
#define WEBKIT_TYPE_DOM_HTML_TEXT_AREA_ELEMENT            (webkit_dom_html_text_area_element_get_type())
#define WEBKIT_DOM_HTML_TEXT_AREA_ELEMENT(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_DOM_HTML_TEXT_AREA_ELEMENT, WebKitDOMHTMLTextAreaElement))
#define WEBKIT_DOM_HTML_TEXT_AREA_ELEMENT_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_DOM_HTML_TEXT_AREA_ELEMENT, WebKitDOMHTMLTextAreaElementClass)
#define WEBKIT_DOM_IS_HTML_TEXT_AREA_ELEMENT(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_DOM_HTML_TEXT_AREA_ELEMENT))
#define WEBKIT_DOM_IS_HTML_TEXT_AREA_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_DOM_HTML_TEXT_AREA_ELEMENT))
#define WEBKIT_DOM_HTML_TEXT_AREA_ELEMENT_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_DOM_HTML_TEXT_AREA_ELEMENT, WebKitDOMHTMLTextAreaElementClass))

struct _WebKitDOMHTMLTextAreaElement {
    WebKitDOMHTMLElement parent_instance;
};

struct _WebKitDOMHTMLTextAreaElementClass {
    WebKitDOMHTMLElementClass parent_class;
};

WEBKIT_API GType
webkit_dom_html_text_area_element_get_type (void);

/**
 * webkit_dom_html_text_area_element_select:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_select(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_check_validity:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_text_area_element_check_validity(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_custom_validity:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @error: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_custom_validity(WebKitDOMHTMLTextAreaElement* self, const gchar* error);

/**
 * webkit_dom_html_text_area_element_set_selection_range:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @start: A #glong
 * @end: A #glong
 * @direction: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_selection_range(WebKitDOMHTMLTextAreaElement* self, glong start, glong end, const gchar* direction);

/**
 * webkit_dom_html_text_area_element_get_default_value:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_default_value(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_default_value:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_default_value(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_form:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLFormElement*
webkit_dom_html_text_area_element_get_form(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_get_validity:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMValidityState*
webkit_dom_html_text_area_element_get_validity(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_get_cols:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_text_area_element_get_cols(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_cols:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #glong
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_cols(WebKitDOMHTMLTextAreaElement* self, glong value);

/**
 * webkit_dom_html_text_area_element_get_dir_name:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_dir_name(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_dir_name:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_dir_name(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_disabled:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_text_area_element_get_disabled(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_disabled:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gboolean
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_disabled(WebKitDOMHTMLTextAreaElement* self, gboolean value);

/**
 * webkit_dom_html_text_area_element_get_autofocus:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_text_area_element_get_autofocus(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_autofocus:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gboolean
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_autofocus(WebKitDOMHTMLTextAreaElement* self, gboolean value);

/**
 * webkit_dom_html_text_area_element_get_max_length:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_text_area_element_get_max_length(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_max_length:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #glong
 * @error: #GError
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_max_length(WebKitDOMHTMLTextAreaElement* self, glong value, GError **error);

/**
 * webkit_dom_html_text_area_element_get_name:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_name(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_name:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_name(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_placeholder:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_placeholder(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_placeholder:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_placeholder(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_read_only:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_text_area_element_get_read_only(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_read_only:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gboolean
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_read_only(WebKitDOMHTMLTextAreaElement* self, gboolean value);

/**
 * webkit_dom_html_text_area_element_get_required:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_text_area_element_get_required(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_required:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gboolean
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_required(WebKitDOMHTMLTextAreaElement* self, gboolean value);

/**
 * webkit_dom_html_text_area_element_get_rows:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_text_area_element_get_rows(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_rows:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #glong
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_rows(WebKitDOMHTMLTextAreaElement* self, glong value);

/**
 * webkit_dom_html_text_area_element_get_wrap:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_wrap(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_wrap:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_wrap(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_value:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_value(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_value:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_value(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_text_length:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gulong
webkit_dom_html_text_area_element_get_text_length(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_get_will_validate:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_text_area_element_get_will_validate(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_get_validation_message:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_validation_message(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_get_selection_start:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_text_area_element_get_selection_start(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_selection_start:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #glong
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_selection_start(WebKitDOMHTMLTextAreaElement* self, glong value);

/**
 * webkit_dom_html_text_area_element_get_selection_end:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_text_area_element_get_selection_end(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_selection_end:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #glong
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_selection_end(WebKitDOMHTMLTextAreaElement* self, glong value);

/**
 * webkit_dom_html_text_area_element_get_selection_direction:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_text_area_element_get_selection_direction(WebKitDOMHTMLTextAreaElement* self);

/**
 * webkit_dom_html_text_area_element_set_selection_direction:
 * @self: A #WebKitDOMHTMLTextAreaElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_text_area_element_set_selection_direction(WebKitDOMHTMLTextAreaElement* self, const gchar* value);

/**
 * webkit_dom_html_text_area_element_get_labels:
 * @self: A #WebKitDOMHTMLTextAreaElement
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeList*
webkit_dom_html_text_area_element_get_labels(WebKitDOMHTMLTextAreaElement* self);

G_END_DECLS

#endif /* WebKitDOMHTMLTextAreaElement_h */
