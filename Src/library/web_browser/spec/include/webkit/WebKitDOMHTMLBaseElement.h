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

#ifndef WebKitDOMHTMLBaseElement_h
#define WebKitDOMHTMLBaseElement_h

#include "webkit/webkitdomdefines.h"
#include <glib-object.h>
#include <webkit/webkitdefines.h>
#include "webkit/WebKitDOMHTMLElement.h"


G_BEGIN_DECLS
#define WEBKIT_TYPE_DOM_HTML_BASE_ELEMENT            (webkit_dom_html_base_element_get_type())
#define WEBKIT_DOM_HTML_BASE_ELEMENT(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_DOM_HTML_BASE_ELEMENT, WebKitDOMHTMLBaseElement))
#define WEBKIT_DOM_HTML_BASE_ELEMENT_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_DOM_HTML_BASE_ELEMENT, WebKitDOMHTMLBaseElementClass)
#define WEBKIT_DOM_IS_HTML_BASE_ELEMENT(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_DOM_HTML_BASE_ELEMENT))
#define WEBKIT_DOM_IS_HTML_BASE_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_DOM_HTML_BASE_ELEMENT))
#define WEBKIT_DOM_HTML_BASE_ELEMENT_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_DOM_HTML_BASE_ELEMENT, WebKitDOMHTMLBaseElementClass))

struct _WebKitDOMHTMLBaseElement {
    WebKitDOMHTMLElement parent_instance;
};

struct _WebKitDOMHTMLBaseElementClass {
    WebKitDOMHTMLElementClass parent_class;
};

WEBKIT_API GType
webkit_dom_html_base_element_get_type (void);

/**
 * webkit_dom_html_base_element_get_href:
 * @self: A #WebKitDOMHTMLBaseElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_base_element_get_href(WebKitDOMHTMLBaseElement* self);

/**
 * webkit_dom_html_base_element_set_href:
 * @self: A #WebKitDOMHTMLBaseElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_base_element_set_href(WebKitDOMHTMLBaseElement* self, const gchar* value);

/**
 * webkit_dom_html_base_element_get_target:
 * @self: A #WebKitDOMHTMLBaseElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_base_element_get_target(WebKitDOMHTMLBaseElement* self);

/**
 * webkit_dom_html_base_element_set_target:
 * @self: A #WebKitDOMHTMLBaseElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_base_element_set_target(WebKitDOMHTMLBaseElement* self, const gchar* value);

G_END_DECLS

#endif /* WebKitDOMHTMLBaseElement_h */
