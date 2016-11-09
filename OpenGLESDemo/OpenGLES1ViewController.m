//
//  OpenGLES1ViewController.m
//  OpenGLESDemo
//
//  Created by huweidong on 2/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "OpenGLES1ViewController.h"
#import "GLView.h"
#import "NSString+EOCMyAdditions.h"
#import <objc/runtime.h>

@interface OpenGLES1ViewController ()

@property NSString *myName;

@end

@implementation OpenGLES1ViewController

typedef struct {
    GLKVector3  positionCoords;
}
SceneVertex;

static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0}}, // lower right corner
    {{-0.5f,  0.5f, 0.0}}  // upper left corner
};

- (void)dealloc{
    [EAGLContext setCurrentContext:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    GLView *view=[[GLView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:view];
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]],@"View controller's view is not a GLKView");
    //创建一个OpenGL ES 2.0上下文
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    //用新的上下文替代
    [EAGLContext setCurrentContext:view.context];
    //创建一个画板
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(
                                                   1.0f, // Red
                                                   1.0f, // Green
                                                   1.0f, // Blue
                                                   1.0f);// Alpha
    //设置当前上下文的背景颜色
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f); // background color
    //生成、绑定和初始化一个缓冲区的内容
    glGenBuffers(1,&vertexBufferID);     // STEP 1
                 
    glBindBuffer(GL_ARRAY_BUFFER,vertexBufferID);  // STEP 2
                 
    glBufferData(                  // STEP 3
                 GL_ARRAY_BUFFER,  // Initialize buffer contents
                 sizeof(vertices), // Number of bytes to copy
                 vertices,         // Address of bytes to copy
                 GL_STATIC_DRAW);  // Hint: cache in GPU memory
    
    // Setup texture
    CGImageRef imageRef =
    [[UIImage imageNamed:@"leaves.gif"] CGImage];
    
    GLKTextureInfo *textureInfo = [GLKTextureLoader
                                   textureWithCGImage:imageRef
                                   options:nil
                                   error:NULL];
    
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//GLKView委托方法:由视图控制器的视图调用
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.baseEffect prepareToDraw];
    
    // Clear Frame Buffer (erase previous drawing)
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Enable use of positions from bound vertex buffer(使位置从绑定顶点缓冲区的使用)
    glEnableVertexAttribArray(GLKVertexAttribPosition);      // STEP 4
                              
    
    glVertexAttribPointer(          // STEP 5
                          GLKVertexAttribPosition,
                          3,                   // three components per vertex
                          GL_FLOAT,            // data is floating point
                          GL_FALSE,            // no fixed point scaling(不动点缩放)
                          sizeof(SceneVertex), // no gaps in data(没有空白的数据)
                          NULL);               // NULL tells GPU to start at
    // beginning of bound buffer
    
    // Draw triangles using the first three vertices in the
    // currently bound vertex buffer
    glDrawArrays(GL_TRIANGLES,      // STEP 6
                 0,  // Start with first vertex in currently bound buffer(目前开始第一个顶点缓冲)
                 3); // Use three vertices from currently bound buffer(从目前使用三个顶点缓冲)
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
