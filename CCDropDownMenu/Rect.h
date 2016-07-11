//
//  Rect.h
//  CCDropDownMenu
//
//  Created by Kelvin on 7/9/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#ifndef Rect_h
#define Rect_h

#define CGRectSetWidth(rect, width) CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height)

#define CGRectSetHeight(rect, height) CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height)

#define CGRectSetSize(rect, size) CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height)

#define CGRectSetX(rect, x) CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height)

#define CGRectSetY(rect, y) CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height)

#define CGRectSetOrigin(rect, origin) CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)

#endif
