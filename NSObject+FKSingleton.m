#import "NSObject+FKSingleton.h"
#import <objc/runtime.h>

@implementation NSObject (FKSingleton)

static const void *SingletonInstanceKey = &SingletonInstanceKey;

+ (id)allocWithZone:(NSZone *)zone
{
	id sharedInstance = nil;
	@synchronized(self)
	{
		sharedInstance = objc_getAssociatedObject(self, SingletonInstanceKey);
		if (!sharedInstance)
		{
			sharedInstance = NSAllocateObject(self, 0, zone);
			objc_setAssociatedObject(self, SingletonInstanceKey, sharedInstance, OBJC_ASSOCIATION_RETAIN);
		}
	}
	return sharedInstance;
}

@end
