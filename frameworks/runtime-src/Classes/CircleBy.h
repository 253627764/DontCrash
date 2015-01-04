//
//  CircleBy.h
//  DontCrash
//
//  Created by  ws on 12/10/14.
//
//

#ifndef __DontCrash__CircleBy__
#define __DontCrash__CircleBy__

#include "cocos2d.h"
USING_NS_CC;

class CircleBy : public ActionInterval
{
public:
    static CircleBy * create(float tm,Point circleCenter,float numDegree);
    bool init(float tm,Point circleCenter,float degree);
    virtual void update(float);
    virtual void startWithTarget(Node *target);
    virtual CircleBy * reverse() const;
    virtual CircleBy * clone() const;
private:
    Point _circleCenter;
    Point _originCenter;
    float _radius;
    float _numDegree;
    float _degree;
    float _beginDegree;
    int _times;
};

#endif /* defined(__DontCrash__CircleBy__) */
