/*
 Copyright (c) 2015-present, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSURL+SFAdditions.h"

@implementation NSURL (SFAdditions)

- (nullable NSString *)valueForParameterName:(NSString *)name
{
    NSString *query = [self query];
    if (query != nil) {
        NSArray *queryComponents = [query componentsSeparatedByString:@"&"];
        for (NSString *paramNameValuePair in queryComponents) {
            NSArray *paramComponents = [paramNameValuePair componentsSeparatedByString:@"="];
            if ([[paramComponents objectAtIndex:0] caseInsensitiveCompare:name] == NSOrderedSame) {
                return ([paramComponents count] > 1 ? [paramComponents objectAtIndex:1] : nil);
            }
        }
    }
    return nil;
}


- (nullable NSDictionary *)dictionaryFromQuery
{
    NSString *query = [self query];
    NSMutableDictionary *allVaues = [[NSMutableDictionary alloc] init];
    if (query != nil) {
        NSArray *queryComponents = [query componentsSeparatedByString:@"&"];
        for (NSString *paramNameValuePair in queryComponents) {
            NSArray *paramComponents = [paramNameValuePair componentsSeparatedByString:@"="];
            NSString *key = [paramComponents objectAtIndex:0];
            NSString *value = @"";
            if ([paramComponents count] > 1) {
                value = [paramComponents objectAtIndex:1];
                value = [[value stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByRemovingPercentEncoding];
            }
            [allVaues setObject:value forKey:key];
        }
    }
    return allVaues;
}

@end
